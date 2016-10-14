# Preface #

This document describes the functionality provided by the xld-folder-plugin.

See the **XL Deploy Reference Manual** for background information on XL Deploy and deployment concepts.

# CI status #

[![Build Status][xld-folder-plugin-travis-image]][xld-folder-plugin-travis-url]
[![Codacy Badge][xld-folder-plugin-codacy-image] ][xld-folder-plugin-codacy-url]
[![Code Climate][xld-folder-plugin-code-climate-image] ][xld-folder-plugin-code-climate-url]

[xld-folder-plugin-travis-image]: https://travis-ci.org/xebialabs-community/xld-folder-plugin.svg?branch=master
[xld-folder-plugin-travis-url]: https://travis-ci.org/xebialabs-community/xld-folder-plugin
[xld-folder-plugin-codacy-image]: https://api.codacy.com/project/badge/Grade/0c1d76f521374e819f37e40ab6132e7b
[xld-folder-plugin-codacy-url]: https://www.codacy.com/app/joris-dewinne/xld-folder-plugin
[xld-folder-plugin-code-climate-image]: https://codeclimate.com/github/xebialabs-community/xld-folder-plugin/badges/gpa.svg
[xld-folder-plugin-code-climate-url]: https://codeclimate.com/github/xebialabs-community/xld-folder-plugin



# Overview #

The xld-folder plugin is a XL Deploy plugin that adds capability to upload a folder as an archive in XLD, transfer the folder as an archive to the target host and extract it on the target host.

## Requirements

* **XL Deploy requirements**
	* **XL Deploy**: version 5.0+

## Types ##

+ `xld.Folder`: A folder uploaded as an archive and copied to the target host as an archive. Extracted on the target host.
  + On linux: `zip`, `gzip`, `bzip2` and `tar` are supported.
  + On windows: `zip` is supported.