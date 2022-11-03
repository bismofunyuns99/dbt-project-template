
  {% macro set_query_tag() -%}
  {# set new_query_tag = 'DBTmodel: '{{ this }} #} 
  
  {% set query_tag %}
  dbtModel: {{ this.identifier | upper }}
  {% endset %} 
  
  {% set new_query_tag = query_tag | trim  %}

  {% if new_query_tag %}
    {% set original_query_tag = get_current_query_tag() %}
    {{ log("Setting query_tag to '" ~ new_query_tag ~ "'. Will reset to '" ~ original_query_tag ~ "' after materialization.") }}
    {% do run_query("alter session set query_tag = '{}'".format(new_query_tag)) %}
    {{ return(original_query_tag)}}
  {% endif %}
  {{ return(none)}}
{% endmacro %}
