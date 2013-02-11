## -*- coding: utf-8 -*-

<%inherit file="../generic.mako"/>


<p>Voici la liste complète des auteurs de FaitMain, ainsi que les
articles qu'ils ont écrit.</p>

<ul>
%for author_id, info in authors:
 <li><a href="${info['link']}"><strong>${info['name']}</strong></a>
  <ul>
   %for title, path in info['articles']:
   <li><a href="${config['siteurl']}/${path}">${title}</a></li>
   %endfor
  </ul>
 </li>
%endfor
</ul>

<p>
  <a href="/apropos.html"><strong>Devenez auteur!</strong></a>
</p>
