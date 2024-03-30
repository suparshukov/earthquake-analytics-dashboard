{#
    This macro returns the description of the is_sifnificant 
#}

{% macro get_significance(magnitude) -%}

    case 
    WHEN {{magnitude}} < 3 THEN 'Insignificant'
    WHEN ({{magnitude}}>=3 AND {{magnitude}}<4) THEN 'Minor'
    WHEN ({{magnitude}}>=4 AND {{magnitude}}<5) THEN 'Light'
    WHEN ({{magnitude}}>=5 AND {{magnitude}}<6) THEN 'Moderate'
    WHEN ({{magnitude}}>=6 AND {{magnitude}}<7) THEN 'Strong'
    WHEN ({{magnitude}}>=7 AND {{magnitude}}<8) THEN 'Major'
    WHEN ({{magnitude}}>=8) THEN 'Great'
    ELSE 'Undefined'
    end

{%- endmacro %}
