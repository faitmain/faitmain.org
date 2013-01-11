## -*- coding: utf-8 -*-

<%inherit file="generic.mako"/>

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
