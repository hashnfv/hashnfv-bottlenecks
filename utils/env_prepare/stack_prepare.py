#!/usr/bin/env python
##############################################################################
# Copyright (c) 2017 Huawei Technologies Co.,Ltd and others.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################
import os
import subprocess
import errno
from utils.logger import Logger
from utils.parser import Parser as config
import utils.infra_setup.heat.manager as utils
import utils.infra_setup.runner.docker_env as docker_env

LOG = Logger(__name__).getLogger()


def _prepare_env_daemon(test_yardstick):

    rc_file = config.bottlenecks_config["rc_dir"]

    if not os.path.exists(rc_file):
        installer_ip = os.environ.get('INSTALLER_IP', 'undefined')
        installer_type = os.environ.get('INSTALLER_TYPE', 'undefined')
        _get_remote_rc_file(rc_file, installer_ip, installer_type)

    _source_file(rc_file)

    if not os.environ.get("EXTERNAL_NETWORK"):
        _append_external_network(rc_file)
    if test_yardstick:
        yardstick_contain = docker_env.yardstick_info["container"]
        cmd = "cp %s %s" % (rc_file,
                            config.bottlenecks_config["yardstick_rc_dir"])
        docker_env.docker_exec_cmd(yardstick_contain,
                                   cmd)
        file_orig = ("/home/opnfv/repos/yardstick/etc"
                     "/yardstick/yardstick.conf.sample")
        file_after = "/etc/yardstick/yardstick.conf"
        cmd = "cp %s %s" % (file_orig,
                            file_after)
        docker_env.docker_exec_cmd(yardstick_contain,
                                   cmd)
        cmd = "sed -i '13s/http/file/g' /etc/yardstick/yardstick.conf"
        docker_env.docker_exec_cmd(yardstick_contain,
                                   cmd)

    # update the external_network
    _source_file(rc_file)


def file_copy(src_file, dest_file):
    src = file(src_file, "r+")
    des = file(dest_file, "w+")
    des.writelines(src.read())
    src.close()
    des.close()


def _get_remote_rc_file(rc_file, installer_ip, installer_type):

    RELENG_DIR = config.bottlenecks_config["releng_dir"]
    OS_FETCH_SCRIPT = config.bottlenecks_config["fetch_os"]
    os_fetch_script = os.path.join(RELENG_DIR, OS_FETCH_SCRIPT)

    try:
        cmd = [os_fetch_script, '-d', rc_file, '-i', installer_type,
               '-a', installer_ip]
        p = subprocess.Popen(cmd, stdout=subprocess.PIPE)
        p.communicate()[0]

        if p.returncode != 0:
            LOG.debug('Failed to fetch credentials from installer')
    except OSError as e:
        if e.errno != errno.EEXIST:
            raise


def _source_file(rc_file):
    p = subprocess.Popen(". %s; env" % rc_file, stdout=subprocess.PIPE,
                         shell=True)
    output = p.communicate()[0]
    env = dict((line.split('=', 1) for line in output.splitlines()))
    os.environ.update(env)
    return env


def _append_external_network(rc_file):
    neutron_client = utils._get_neutron_client()
    networks = neutron_client.list_networks()['networks']
    try:
        ext_network = next(n['name'] for n in networks if n['router:external'])
    except StopIteration:
        LOG.warning("Can't find external network")
    else:
        cmd = 'export EXTERNAL_NETWORK=%s' % ext_network
        try:
            with open(rc_file, 'a') as f:
                f.write(cmd + '\n')
        except OSError as e:
            if e.errno != errno.EEXIST:
                raise
