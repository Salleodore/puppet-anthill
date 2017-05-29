# Puppet modules for Anthill Platform

This repository contains a list of Puppet modules (along with dependencies) that
are required for Anthill Platform to run on your server.

### Installation

As any other Puppet modules, you may simply clone all this modules in your
`modules` directory.

```commandline
cd /etc/puppetlabs/code/environments/production/modules
git clone --recursive https://github.com/anthill-platform/puppet-anthill.git .
```

This assumes you are using `production` environment and your `modules` directory is empty, otherwise you may fork this repo and add your modules into it, and then 
clone your repo instead. You also might simply put them into `/etc/puppetlabs/code/modules` as well.
