#!/bin/sh

mix deps.clean --all && mix deps.get && mix compile
