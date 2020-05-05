{% from "runit/map.jinja" import runit with context %}

################
# STOP SERVICE #
################

{% macro stop_service(name) -%}
{% set service = runit.service_dir | path_join(name) %}
{{ name }}_stop_service:
  cmd.run:
    - name: {{ runit.sv }} down {{ service }}
    - onlyif:
      - test -d {{ service }}
{%- endmacro %}

#################
# START SERVICE #
#################

{% macro start_service(name) -%}
{% set service = runit.service_dir | path_join(name) %}
{{ name }}_start_service:
  file.managed:
    - name: {{ service | path_join('run') }}
    - mode: 754
  cmd.run:
    - name: {{ runit.sv }} up {{ service }}
    - onlyif:
      - test -d {{ service }}
      - test -p {{ service | path_join('supervise', 'ok') }}
    - require:
      - file: {{ name }}_start_service
{%- endmacro %}

###################
# RESTART SERVICE #
###################

{% macro restart_service(name) -%}
{% set service = runit.service_dir | path_join(name) %}
{{ name }}_restart_service:
  cmd.run:
    - name: {{ runit.sv }} restart {{ service }}
    - onlyif:
      - test -d {{ service }}
{%- endmacro %}

##################
# SIGNAL SERVICE #
##################

{% macro signal_service(name, signal='hup') -%}
{% set service = runit.service_dir | path_join(name) %}
{{ name }}_signal_service:
  cmd.run:
    - name: {{ runit.sv }} {{ signal }} {{ service }}
    - onlyif:
      - test -d {{ service }}
{%- endmacro %}

##################
# REMOVE SERVICE #
##################

{% macro remove_service(name) -%}
{% set service = 'runit.service_dir' | path_join(name) %}
{{ name }}_remove_service:
  file.absent:
    - name: {{ service }}
{%- endmacro %}
