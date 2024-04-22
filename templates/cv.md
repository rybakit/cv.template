{%- set max_exp_items_to_show = 3 -%}

# {{ full_name }}

{{ location }} | [{{ contact_details.email }}](mailto:{{ contact_details.email }}) | [GitHub]({{ contact_details.github }}) | [LinkedIn]({{ contact_details.linkedin }})


## Summary

{{ summary }}


## Experience
{% for item in experience %}
{%- if loop.index > max_exp_items_to_show %}
{%- if loop.index == max_exp_items_to_show + 1 %}
### Earlier Experience
_Varios locations_
{% endif %}
 * {{ item.title }}, [{{ item.company_name }}]({{ item.company_url }}), _{{ item.dates }}_
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
**{{ item.school }}**, {{ item.field_of_study }}, _{{ item.dates }}_
{% endfor %}

## Certifications
{% for item in certificates %}
{%- if item.url is defined and item.url|length %}
 * [{{ item.title }}]({{ item.url }})
{%- else %}
 * {{ item.title }}
{%- endif -%}
{%- if item.date is defined and item.date|length %}, _{{ item.date }}_{% endif -%}
{% endfor %}

## Training
{%- for item in training -%}
{% if item.url is defined and item.url|length %}
 * [{{ item.title }}]({{ item.url }})
{%- else %}
 * {{ item.title }}
{%- endif -%}
{%- if item.dates is defined and item.dates|length %}, _{{ item.dates }}_{% endif -%}
{% endfor %}


## Skills

{{ skills|join(", ") }}.


## Open Source Projects
{% for item in oss_projects %}
 * [{{ item.title }}]({{ item.url }}):{{ " " }}
   {%- if item.description is defined and item.description|length -%}
   {{ item.description }}
   {%- endif %}
   {%- if item.note is defined and item.note|length %}

   _{{ item.note }}_
   {%- endif %}
{% endfor %}


## Publications
{% for item in publications %}
 * [{{ item.title }}]({{ item.url }})
{%- endfor %}
