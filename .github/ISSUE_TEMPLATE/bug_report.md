name: Bug report
about: Create a report to help improve WorldChat
title: "bug: "
labels: ["bug"]
assignees: ["Varun-Patkar"]

body:
  - type: markdown
    attributes:
      value: |
        Thanks for taking the time to fill out this bug report!

  - type: input
    id: version
    attributes:
      label: Version
      description: What version of WorldChat are you running?
      placeholder: e.g., v0.1.0
    validations:
      required: true

  - type: textarea
    id: what-happened
    attributes:
      label: What happened?
      description: Also tell us, what did you expect to happen?
      placeholder: Tell us what you see!
    validations:
      required: true

  - type: textarea
    id: reproduction
    attributes:
      label: Steps to reproduce
      description: How can we reproduce this issue?
      value: |
        1. 
        2. 
        3. 

  - type: dropdown
    id: browsers
    attributes:
      label: Browser / Environment
      multiple: true
      options:
        - Chrome / Chromium
        - Firefox
        - Safari
        - Edge
        - Other
    validations:
      required: false

  - type: textarea
    id: logs
    attributes:
      label: Relevant log output
      description: Please copy and paste any relevant log output. This will be automatically formatted into code, so no need for backticks.
      render: shell
