^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package automatepro_interfaces
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1.1.0 (2026-10-20)
------------------
* Since the ``v1.0.0`` tag, the ``AnalogIn`` fields ``ain_01`` to ``ain_14``
  are ``int16`` instead of ``uint16``, and ``IOFirmwareDiagnostic`` carries
  ``uint8[10] fault_code`` in place of ``uint16 fault_code`` and
  ``uint8[4] reserved``. The published 1.0.0 package, built from ``master``,
  already had both changes; code built from the ``v1.0.0`` tag cannot exchange
  either message with this release.
* Also since the ``v1.0.0`` tag: the ``CAN`` message, the ``IOConfig``
  service, and the error-code and bitmask constants of
  ``IOFirmwareDiagnostic``.
* Remove ``msg/GNSSHeading.msg``, which was never built into the package.
* Tidy the comments of the definitions; no field, type or constant changes.
* Export ``rosidl_default_runtime`` and declare ``rosidl_default_generators``
  as a build tool dependency; require CMake 3.22 and build the generated C++
  as C++17.
* Publish the arm64 and amd64 packages only for a ``v*`` tag on ``master``
  that matches ``package.xml``, never replacing a published version. A new CI
  workflow builds and tests every pull request on both architectures and
  lints the workflows, the YAML and the Markdown.
* Name Lemvos Robotics GmbH as maintainer, author and copyright holder;
  ``LICENSE`` is the unmodified Apache License 2.0 text.
* Replace ``ReadMe.md`` with ``README.md``, which documents every type; add
  ``CONTRIBUTING.md``, ``SECURITY.md`` and ``doc/``.

1.0.0 (2025-01-29)
------------------
* First tagged release.
