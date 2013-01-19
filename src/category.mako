## -*- coding: utf-8 -*-

<%inherit file="generic.mako"/>

<%block name="first_h1"> 
</%block>

<div class="span12">
<img class="centered span12" src="media/${category}_banner.jpg"/></a>
</div>

%if paths:
 <p>Tous les articles sur ce sujet:</p>
  <ul>
   %for path, title_ in paths:
    <li><a href="${path}">${title_}</a></li>
   %endfor
  </ul>
%else:
  <p>Aucun article sur ce sujet pour le moment.</p>
%endif
