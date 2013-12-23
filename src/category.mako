## -*- coding: utf-8 -*-

<%inherit file="generic.mako"/>

<%block name="first_h1"> 
</%block>

<h1>${category.capitalize()}</h1>

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
