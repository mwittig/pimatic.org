###
layout: default
###

fs = @require 'fs'

plugins = @getAllPlugins()
plugin = null
for p in plugins
  if p.name is @document.pluginName
    plugin = p
    break

article id: 'page', =>
  div class: 'page-content', @content
  div =>
    if fs.existsSync(p.compiledConfigSchema)
      h2 "Plugin Config Options"
      schema = JSON.parse fs.readFileSync(p.compiledConfigSchema).toString()
      text @printConfigShema schema
    if fs.existsSync(p.compiledDeviceConfigSchema)
      h2 "Device Config Options"
      schema = JSON.parse fs.readFileSync(p.compiledDeviceConfigSchema).toString()
      if schema.title?
        div schema.title
      for device, config of schema
        if device is "title" then continue
        h3 device
        text @printConfigShema config
  div => "#{p.name} is written by #{@author(p).name}"
