runit_pkg:
  pkg.installed:
    - name: runit

runit_service_directory:
  file.directory:
    - name: /var/service
    - require:
      - pkg: runit_pkg
