# Preface #

This document describes the functionality provided by the xld-folder-plugin.

See the **XL Deploy Reference Manual** for background information on XL Deploy and deployment concepts.

# CI status #

[![Build Status][xld-folder-plugin-travis-image]][xld-folder-plugin-travis-url]
[![Codacy Badge][xld-folder-plugin-codacy-image] ][xld-folder-plugin-codacy-url]
[![Code Climate][xld-folder-plugin-code-climate-image] ][xld-folder-plugin-code-climate-url]
[![License: MIT][xld-folder-plugin-license-image] ][xld-folder-plugin-license-url]
[![Github All Releases][xld-folder-plugin-downloads-image] ]()


[xld-folder-plugin-travis-image]: https://travis-ci.org/xebialabs-community/xld-folder-plugin.svg?branch=master
[xld-folder-plugin-travis-url]: https://travis-ci.org/xebialabs-community/xld-folder-plugin
[xld-folder-plugin-codacy-image]: https://api.codacy.com/project/badge/Grade/16aa668300584f989546cfecef937390
[xld-folder-plugin-codacy-url]: https://www.codacy.com/app/joris-dewinne/xld-folder-plugin
[xld-folder-plugin-code-climate-image]: https://codeclimate.com/github/xebialabs-community/xld-folder-plugin/badges/gpa.svg
[xld-folder-plugin-code-climate-url]: https://codeclimate.com/github/xebialabs-community/xld-folder-plugin
[xld-folder-plugin-license-image]: https://img.shields.io/badge/License-MIT-yellow.svg
[xld-folder-plugin-license-url]: https://opensource.org/licenses/MIT
[xld-folder-plugin-downloads-image]: https://img.shields.io/github/downloads/xebialabs-community/xld-folder-plugin/total.svg




# Overview #

The xld-folder plugin is a XL Deploy plugin that adds capability to upload a folder as an archive in XLD, transfer the folder as an archive to the target host and extract it on the target host.

## Requirements

* **XL Deploy requirements**
	* **XL Deploy**: version 5.0+

## Types ##

+ `xld.Folder`: A folder uploaded as an archive and copied to the target host as an archive. Extracted on the target host.
  + On linux: `zip`, `gzip`, `bzip2` and `tar` are supported.
      + Additional tar command options are: `strip-components`, `members`
  + On windows: `zip` is supported.
