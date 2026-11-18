^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package automatepro_interfaces
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1.1.0 (2026-11-18)
------------------
* No message or service changes a field, a type or a constant against the
  published 1.0.0 package.
* Remove ``msg/GNSSHeading.msg`` from the source; it was never built into the
  package.
* Tidy the comments of the definitions.
* Export ``rosidl_default_runtime`` and declare ``rosidl_default_generators``
  as a build tool dependency; require CMake 3.22 and build the generated C++
  as C++17.
* Publish the arm64 and amd64 packages only for a ``v*`` tag on ``master``
  that matches ``package.xml``, never replacing a published version. A new CI
  workflow builds and tests every pull request on both architectures, lints
  the workflows, the YAML, the Markdown and the pull request title, and
  reports the result as the ``all-green`` check.
* Name Lemvos Robotics GmbH as maintainer, author and copyright holder;
  ``LICENSE`` is the unmodified Apache License 2.0 text.
* Replace ``ReadMe.md`` with ``README.md``, which documents every type; add
  ``CONTRIBUTING.md``, ``SECURITY.md`` and ``doc/``.

1.0.0 (2025-01-29)
------------------
* First release: the messages ``AnalogIn``, ``CAN``, ``DigitalDriveOut``,
  ``DigitalIn``, ``DigitalOut``, ``EStopStatus``, ``IOControllerDiagnostic``,
  ``IOFirmwareDiagnostic`` and ``WarningSystems``, and the services
  ``IOConfig`` and ``ReqDigitalIn``.
* The published package was built from ``master`` after the ``v1.0.0`` tag.
  The tag's source differs: ``AnalogIn`` has ``uint16`` inputs instead of
  ``int16``, ``IOFirmwareDiagnostic`` has ``uint16 fault_code`` and
  ``uint8[4] reserved`` instead of ``uint8[10] fault_code`` and no constants,
  and ``CAN`` and ``IOConfig`` are missing. Code built from the tag cannot
  exchange ``AnalogIn`` or ``IOFirmwareDiagnostic`` with the published
  package.
