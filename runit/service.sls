{% from "runit/map.jinja" import runit with context %}

include:
  - runit.install

runit_runsvdir:
  service.running:
    - name: {{ runit.service_name }}
    - enable: True
    - watch:
      - pkg: runit_pkg
      - file: runit_service_directory
