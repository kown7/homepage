----------
title: Jenkins in the DMZ
----------


# Introduction

I want to summarize my experience with Jenkins in a DMZ. I haven't
found a comprehensive guide. The agents are running on our side of the
DMZ and can't be accessed from the DMZ. The Jenkins server itself runs
in DMZ and is accessible from both sides.

Hence we need to start the agents manually on our side. Furthermore
the numbers of gaps in the firewall into the DMZ is to be minimized.


# Jenkins

It is assumed that Jenkins is configured with a jenkins.yaml
configuration-as-code setup. The JNLP port is set to 50_000 as is
fairly standard. A simple `docker-compose up -d` should get you far.

```yaml
TODO : 5000
```

## Firewall

There needs to be a rule for port 443 for the web UI. The agents
the above configured 50_000 port.


# Agents

Yadda Yadda
