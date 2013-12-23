## -*- coding: utf-8 -*-

<%inherit file="generic.mako"/>

<%block name="first_h1"> 
</%block>

<<<<<<< HEAD
<h1>${category.capitalize()}</h1>
=======
<img class="row-fluid centered" src="${config['cdn']}/media/${category}_banner.jpg"/>

<br/><br/>
>>>>>>> b4ae150bb234746e454050bc39452dfaee8221b3

%if paths:
 <p>Tous les articles sur ce sujet:</p>
  <ul>
   %for path, title_ in paths:
    <li><a href="${config['siteurl']}/${path}">${title_}</a></li>
   %endfor
  </ul>
%else:
  <p>Aucun article sur ce sujet pour le moment.</p>
%endif
