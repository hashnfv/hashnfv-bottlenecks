<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" xml:lang="es"><head><!--
        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
              This file is generated from xml source: DO NOT EDIT
        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      -->
<title>M�dulos de MultiProcesamiento (MPMs) - Servidor HTTP Apache</title>
<link href="./style/css/manual.css" rel="stylesheet" media="all" type="text/css" title="Main stylesheet" />
<link href="./style/css/manual-loose-100pc.css" rel="alternate stylesheet" media="all" type="text/css" title="No Sidebar - Default font size" />
<link href="./style/css/manual-print.css" rel="stylesheet" media="print" type="text/css" />
<link href="./images/favicon.ico" rel="shortcut icon" /></head>
<body id="manual-page"><div id="page-header">
<p class="menu"><a href="./mod/">M�dulos</a> | <a href="./mod/directives.html">Directivas</a> | <a href="./faq/">Preguntas Frecuentes</a> | <a href="./glossary.html">Glosario</a> | <a href="./sitemap.html">Mapa de este sitio web</a></p>
<p class="apache">Versi�n 2.0 del Servidor HTTP Apache</p>
<img alt="" src="./images/feather.gif" /></div>
<div class="up"><a href="./"><img title="&lt;-" alt="&lt;-" src="./images/left.gif" /></a></div>
<div id="path">
<a href="http://www.apache.org/">Apache</a> &gt; <a href="http://httpd.apache.org/">Servidor HTTP</a> &gt; <a href="http://httpd.apache.org/docs/">Documentaci�n</a> &gt; <a href="./">Versi�n 2.0</a></div><div id="page-content"><div id="preamble"><h1>M�dulos de MultiProcesamiento (MPMs)</h1>
<div class="toplang">
<p><span>Idiomas disponibles: </span><a href="./de/mpm.html" hreflang="de" rel="alternate" title="Deutsch">&nbsp;de&nbsp;</a> |
<a href="./en/mpm.html" hreflang="en" rel="alternate" title="English">&nbsp;en&nbsp;</a> |
<a href="./es/mpm.html" title="Espa�ol">&nbsp;es&nbsp;</a> |
<a href="./ja/mpm.html" hreflang="ja" rel="alternate" title="Japanese">&nbsp;ja&nbsp;</a> |
<a href="./ko/mpm.html" hreflang="ko" rel="alternate" title="Korean">&nbsp;ko&nbsp;</a> |
<a href="./ru/mpm.html" hreflang="ru" rel="alternate" title="Russian">&nbsp;ru&nbsp;</a> |
<a href="./tr/mpm.html" hreflang="tr" rel="alternate" title="T�rk�e">&nbsp;tr&nbsp;</a></p>
</div>

<p>Este documento explica que son los M�dulos de
Multiprocesamiento y como los usa Apache.</p>
</div>
<div id="quickview"><ul id="toc"><li><img alt="" src="./images/down.gif" /> <a href="#introduction">Introducci�n</a></li>
<li><img alt="" src="./images/down.gif" /> <a href="#choosing">C�mo Elegir un MPM</a></li>
<li><img alt="" src="./images/down.gif" /> <a href="#defaults">MPM por defecto</a></li>
</ul></div>
<div class="top"><a href="#page-header"><img alt="top" src="./images/up.gif" /></a></div>
<div class="section">
<h2><a name="introduction" id="introduction">Introducci�n</a></h2>

    <p>Apache est� dise�ado para ser un servidor web potente
    y flexible que pueda funcionar en la m�s amplia variedad de
    plataformas y entornos. Las diferentes plataformas y los
    diferentes entornos, hacen que a menudo sean necesarias diferentes
    caracter�sticas o funcionalidades, o que una misma
    caracter�stica o funcionalidad sea implementada de diferente
    manera para obtener una mayor eficiencia. Apache se ha adaptado
    siempre a una gran variedad de entornos a trav�s de su
    dise�o modular. Este dise�o permite a los
    administradores de sitios web elegir que funcionalidades van a ser
    incluidas en el servidor seleccionando que m�dulos se van a
    usar, ya sea al compilar o al ejecutar el servidor.</p>

    <p>Apache 2.0 extiende este dise�o modular hasta las
    funcionalidades m�s b�sicas de un servidor web. El
    servidor viene con una serie de M�dulos de MultiProcesamiento
    que son los responsables de conectar con los puertos de red de la
    m�quina, acceptar las peticiones, y generar los procesos hijo
    que se encargan de servirlas.</p>

    <p>La extensi�n del dise�o modular a este nivel del
    servidor ofrece dos beneficios importantes:</p>

    <ul>
      <li>Apache puede soportar de una forma m�s f�cil y
      eficiente una amplia variedad de sistemas operativos. En
      concreto, la versi�n de Windows de Apache es mucho m�s
      eficiente, porque el m�dulo <code class="module"><a href="./mod/mpm_winnt.html">mpm_winnt</a></code>
      puede usar funcionalidades nativas de red en lugar de usar la
      capa POSIX como hace Apache 1.3. Este beneficio se extiende
      tambi�n a otros sistemas operativos que implementan sus
      respectivos MPMs.</li>

      <li>El servidor puede personalizarse mejor para las necesidades
      de cada sitio web. Por ejemplo, los sitios web que necesitan
      m�s que nada escalibildad pueden usar un MPM hebrado como
      <code class="module"><a href="./mod/worker.html">worker</a></code>, mientras que los sitios web que
      requieran por encima de otras cosas estabilidad o compatibilidad
      con software antiguo pueden usar
      <code class="module"><a href="./mod/prefork.html">prefork</a></code>. Adem�s, se pueden configurar
      funcionalidades especiales como servir diferentes hosts con
      diferentes identificadores de usuario
      (<code class="module"><a href="./mod/perchild.html">perchild</a></code>).</li>
    </ul>

    <p>A nivel de usuario, los m�dulos de multiprocesamiento
    (MPMs) son como cualquier otro m�dulo de Apache. La
    diferencia m�s importante es que solo un MPM puede estar
    cargado en el servidor en un determinado momento. La lista de MPMs
    disponibles est� en la <a href="mod/">secci�n de
    �ndice de m�dulos</a>.</p>

</div><div class="top"><a href="#page-header"><img alt="top" src="./images/up.gif" /></a></div>
<div class="section">
<h2><a name="choosing" id="choosing">C�mo Elegir un MPM</a></h2>

    <p>Los m�dulos de multiprocesamiento que se van a usar
    posteriormente deben elegirse durante el proceso de
    configuraci�n, y deben ser compilados en el servidor. Los
    compiladores son capaces de optimizar muchas funciones si se usan
    hebras, pero solo si se sabe que se est�n usando hebras.</p>

    <p>Para elegir el m�dulo de multiprocesamiento deseado, use
    el argumento <code>--with-mpm= <em>NAME</em></code> con el script
    <code class="program"><a href="./programs/configure.html">configure</a></code>. <em>NAME</em> es el nombre del MPM
    deseado.</p>

    <p>Una vez que el servidor ha sido compilado, es posible
    determinar que m�dulos de multiprocesamiento ha sido elegido
    usando <code>./httpd -l</code>. Este comando lista todos los
    m�dulos compilados en el servidor, incluido en MPM.</p>
</div><div class="top"><a href="#page-header"><img alt="top" src="./images/up.gif" /></a></div>
<div class="section">
<h2><a name="defaults" id="defaults">MPM por defecto</a></h2>

<p>En la siguiente tabla se muestran los m�dulos de
multiprocesamiento por defecto para varios sistemas operativos.  Estos
ser�n los m�dulos de multiprocesamiento seleccionados si no
se especifica lo contrario al compilar.</p>

<table>

<tr><td>BeOS</td><td><code class="module"><a href="./mod/beos.html">beos</a></code></td></tr>
<tr><td>Netware</td><td><code class="module"><a href="./mod/mpm_netware.html">mpm_netware</a></code></td></tr>
<tr><td>OS/2</td><td><code class="module"><a href="./mod/mpmt_os2.html">mpmt_os2</a></code></td></tr>
<tr><td>Unix</td><td><code class="module"><a href="./mod/prefork.html">prefork</a></code></td></tr>
<tr><td>Windows</td><td><code class="module"><a href="./mod/mpm_winnt.html">mpm_winnt</a></code></td></tr>
</table>
</div></div>
<div class="bottomlang">
<p><span>Idiomas disponibles: </span><a href="./de/mpm.html" hreflang="de" rel="alternate" title="Deutsch">&nbsp;de&nbsp;</a> |
<a href="./en/mpm.html" hreflang="en" rel="alternate" title="English">&nbsp;en&nbsp;</a> |
<a href="./es/mpm.html" title="Espa�ol">&nbsp;es&nbsp;</a> |
<a href="./ja/mpm.html" hreflang="ja" rel="alternate" title="Japanese">&nbsp;ja&nbsp;</a> |
<a href="./ko/mpm.html" hreflang="ko" rel="alternate" title="Korean">&nbsp;ko&nbsp;</a> |
<a href="./ru/mpm.html" hreflang="ru" rel="alternate" title="Russian">&nbsp;ru&nbsp;</a> |
<a href="./tr/mpm.html" hreflang="tr" rel="alternate" title="T�rk�e">&nbsp;tr&nbsp;</a></p>
</div><div id="footer">
<p class="apache">Copyright 2009 The Apache Software Foundation.<br />Licencia bajo los t�rminos de la <a href="http://www.apache.org/licenses/LICENSE-2.0">Apache License, Version 2.0</a>.</p>
<p class="menu"><a href="./mod/">M�dulos</a> | <a href="./mod/directives.html">Directivas</a> | <a href="./faq/">Preguntas Frecuentes</a> | <a href="./glossary.html">Glosario</a> | <a href="./sitemap.html">Mapa de este sitio web</a></p></div>
</body></html>