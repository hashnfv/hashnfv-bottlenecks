##############################################################################
# Copyright (c) 2015 Huawei Technologies Co.,Ltd and others.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

from abc import ABCMeta
from abc import abstractmethod


class VswitchPlugin:
    __metaclass__ = ABCMeta

    @abstractmethod
    def clean(self):
        """implement this clean function to clean environment before and after calling any other functions.

        """
        pass

    @abstractmethod
    def init(self):
        """implements this init function to setup necessary Preconditions.

        """
        pass

    @abstractmethod
    def create_br(self, br_cfg):
        """Create a bridge(virtual switch). Return True for success, return False for failure.

        :param dict    br_cfg: configuration for bridge creation like
                {
                    "type": "ovs",
                    "name": "ovs1",
                    "uplinks": [
                        {
                            "bdf": "04:00.0",
                            "vlan_mode": "access",
                            "vlan_id": "1"
                        }
                    ],
                    "vtep": {},
                }

        """
        pass

    @abstractmethod
    def set_tap_vid(self, tap_cfg):
        """set vlan id or vxlan id for tap device(virtual nic for vm).

        :param dict    tap_cfg: dictionary config for tap device like
                        {
                            "tap_name": "tap_in",
                            "vlan_mode": "access",
                            "vlan_id": "1"
                        }

        """
        pass

    def set_fastlink(self, br_cfg):
        return True