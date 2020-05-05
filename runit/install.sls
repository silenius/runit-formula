{% from "runit/map.jinja" import runit with context %}

runit_pkg:
  pkg.installed:
    - name: {{ runit.pkg }}

runit_service_directory:
  file.directory:
    - name: {{ runit.service_dir }}
    - require:
      - pkg: runit_pkg
