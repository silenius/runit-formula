include:
  - runit.install

runit_runsvdir:
  service.running:
    - name: runsvdir
    - enable: True
    - watch:
      - pkg: runit_pkg
      - file: runit_service_directory
