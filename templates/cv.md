{%- set max_exp_items_to_show = 3 -%}

# {{ full_name }}

{% for key, value in contact_details.items() %}
{{- key }}: [{{ value }}]({{ value }}){% if not loop.last %} \{% endif %}
{% endfor %}

## Summary

{{ summary }}


## Experience

{% for item in experience %}
{%- if loop.index > max_exp_items_to_show %}
{%- if loop.index == max_exp_items_to_show + 1 %}
### Earlier Experience
_Varios locations_
{% endif %}
 * {{ item.title }}, [{{ item.company_name }}]({{ item.company_url }}) _({{ item.dates }})_
{%- else %}
### {{ item.title }}, [{{ item.company_name }}]({{ item.company_url }})
_{{ item.dates }}, {{ item.location }}_
{% for bullet_point in item.bullet_points %}
 * {{ bullet_point -}}
{% endfor %}

_{{ item.keywords|join(", ") }}_
{% endif -%}
{% endfor %}


## Education
{% for item in education %}
### {{ item.title }}
_{{ item.dates }}_
{% endfor %}

## Certifications and Training
{% for item in certificates %}
{%- if item.url is defined and item.url|length %}
 * [{{ item.title }}]({{ item.url }})
{%- else %}
 * {{ item.title }}
{%- endif -%}
{% endfor %}
{%- for item in training -%}
{% if item.url is defined and item.url|length %}
 * [{{ item.title }}]({{ item.url }})
{%- else %}
 * {{ item.title }}
{%- endif -%}
{% endfor %}


## Skills

{{ skills|join(", ") }}.


## Open Source Projects
{% for item in oss_projects %}
 * [{{ item.title }}]({{ item.url }})
   {% if item.description is defined and item.description|length -%}{% if not loop.last %} \{% endif %}
   {{ item.description }}
   {%- endif %}
{% endfor %}

## Publications
{% for item in publications %}
 * [{{ item.title }}]({{ item.url }})
{%- endfor %}
