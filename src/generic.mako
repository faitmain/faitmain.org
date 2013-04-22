## -*- coding: utf-8 -*-

<!DOCTYPE html>
<html lang="fr"><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <%block name="headtitle">
    <title>${title} - Fait Main Magazine</title>
    </%block>
    <link href="${config['siteurl']}/feed.xml" type="application/atom+xml" rel="alternate" title="Flux Atom" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Vulgarisation pour Geeks">
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <link href="${config['cnd']}/media/bootstrap.css" rel="stylesheet">
    <link href="${config['cnd']}/media/bootstrap-responsive.css" rel="stylesheet">
    <link href="${config['cnd']}/media/bootswatch.css" rel="stylesheet">
    <link href="${config['cnd']}/media/pygments_style.css" rel="stylesheet">
    <link rel="shortcut icon" href="${config['cnd']}/favicon.ico" />
</head>

  <body class="preview" data-spy="scroll" data-target=".subnav" data-offset="80">
<div class="navbar navbar-fixed-top">

<div class="navbar-inner">
  <div class="signe">
    <img class="visible-phone" src="${config['cnd']}/media/signe-s.png"></img>
    <img class="hidden-phone" src="${config['cnd']}/media/signe-s.png"></img>
  </div>

<div class="container-fluid">
<div class="row-fluid">
<div class="span10 offset1">

  <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
  <span class="icon-bar"></span>
  </a>
  <a class="brand small-logo visible-phone" href="${config['siteurl']}/index.html">
    <img src="${config['cnd']}/media/logo-typo-m.png"></img>
  </a>
  <a class="brand big-logo hidden-phone" href="${config['siteurl']}/index.html">
    <img src="${config['cnd']}/media/logo-typo-m.png"></img>
  </a>

  <div class="nav-collapse">
  <ul class="nav">
   %for category in config['categories']:
   <li><a href="${config['siteurl']}/${category}.html" title="${category}">${category.capitalize()}</a></li>
   %endfor
  </ul>
  </div><!--/.nav-collapse -->

</div>
</div>
</div>
</div>
</div>


<div class="container-fluid">
 <div class="row-fluid">
 <div class="span9 offset1">
  <%block name="first_h1">
  <div class="page-header">
    <h1>${title}</h1>
  </div>
  </%block>

  %if body:
    ${body}
  %else:
    ${self.body()}
  %endif
 </div>  <!-- end of body span9 -->
   <div class="span2">
     <div class="sidebar-nav">
      <ul class="nav-list nav-menu">
        <%block name="sections">
          %if doc_sections:
           <li class="nav-header" style="color:black">Contenu</li>
            %for name, id_ in doc_sections:
             <li><a title="Mailing List" href="#${id_}">${name}</a></li>
            %endfor
          %endif
        </%block>

        <li class="nav-header" style="color:black">Recherche</li>
        <li class="nav-header">
          <form class="form-search" action="${config['siteurl']}/recherche.html" method="get">
           <input type="text" class="input-small search-query" name="query"/>
         </form>
        </li>
        <li class="nav-header" style="color:black">Archives</li>
        <li>
          <a href="${config['siteurl']}/volume-1/index.html">
           Volume 1
         </a>
        </li>

        <li class="nav-header" style="color:black">Social</li>
        <li>
          <a target="_blank" title="Forums" href="http://forums.faitmain.org">Les Forums</a>
        </li>
        <li>
          <a title="Auteurs" href="${config['siteurl']}/auteurs/index.html">Les Auteurs</a>
        </li>

        <li>
          <a title="Mailing List" href="${config['siteurl']}/mailing.html">Mailing List</a>
        </li>
        <li>
          <a target="_blank" title="Twitter" href="http://twitter.com/FaitMainMag" id="toptwitter" rel="nofollow">Twitter</a>
        </li>
        <li>
           <a target="_blank" href="https://plus.google.com/u/0/communities/117661540788222488034" id="topgoogleplus" rel="nofollow">Google+</a> </li>
        <li>
           <a target="_blank" title="GitHub" href="http://github.com/faitmain" id="topgithub">Github</a>
        </li>
        <li>
          <a target="_blank" title="Atom Feed" href="${config['siteurl']}/feed.xml" id="atom">Flux Atom
          </a>
        </li>
        <li class="nav-header" style="color:black">Faites un don!</li>

        <li class="nav-header">
           <a href="https://flattr.com/thing/1146395/Fait-Main-Magazine" target="_blank">
             <img src="${config['cnd']}/media/flattr-badge-large.png" alt="Flattr this" title="Flattr this" border="0" />
           </a>
        </li>
</ul>

     </div>
   </div>

 </div> <!-- end of row-fluid -->

<br/><br/>

  <footer id="footer" class="span12">
   <p class="pull-right"><a href="#"><img src="${config['cnd']}/media/up.png"></a></p>

    <%block name="footer">
    <div class="links">
      <ul>
        <li>© 2013 FaitMain</li>
        <li>ISSN 2261-8376</li>
        <li><a href="${config['siteurl']}/apropos.html">A propos</a></li>
        <li>Contenu <a href="https://creativecommons.org/licenses/by-nc-sa/3.0/deed.fr">CC-By-NC-SA 3.0</a></li>
      </ul>

     </div>

      <div style="clear:both"/>
    </%block>
  </footer>

</div> <!-- end container -->

    <script src="${config['cnd']}/media/jquery.js"></script>
    <script async src="${config['cnd']}/media/bootstrap.js"></script>
    <script src="${config['cnd']}/media/retina.js"></script>
   <%block name="script"></%block>
</body></html>

