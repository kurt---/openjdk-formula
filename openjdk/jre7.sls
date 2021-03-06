{%- from "openjdk/map.jinja" import openjdk with context %}

{% set settings = salt['grains.filter_by']({
  'Debian': {
    'package': 'openjdk-7-jre',
    'target': '/etc/alternatives/jre',
  },
  'RedHat': {
    'package': 'java-1.7.0-openjdk',
    'target': '/etc/alternatives/jre',
  },
}) %}

include:
  - openjdk.env

install_openjdk:
  pkg:
    - installed
    - name: {{ settings.package }}

{{ openjdk.java_home }}:
  file:
    - symlink
    - target: {{ settings.target }}
    - makedirs: true
