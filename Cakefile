{exec, spawn} = require "child_process"

_spawn = spawn
_exec = exec

spawn = (command, opts) ->
  res = _spawn command, opts
  res.stdout.on "data", (data) -> console.log data.toString()
  res.stderr.on "data", (data) -> console.log data.toString()

###
exec = (command) ->
  _exec command, (err, stdout, stderr) ->
    console.log stdout if stdout?
    console.log stderr if stderr?

# Tasks
# ##############################################################################

task "build", ->
  spawn "coffee", ["-o", "js/", "-c", "coffee/"]

task "watch", ->
  spawn "coffee", ["-o", "js/", "-w", "-c", "coffee/"]
