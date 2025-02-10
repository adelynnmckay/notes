---
layout: page 
permalink: /
title: Main Page
date: 1970-01-01 00:00:01 +0000
---

Notes of Adelynn McKay, see [adelynnmckay.com](http://adelynnmckay.com) for more.

<ul>
    {%- for page in site.pages -%}
    <li>
        <a href="{{ page.url }}">{{ page.title }}</a>
        <span>{{ page.date }}</span>
    </li>
    {%- endfor -%}
</ul>