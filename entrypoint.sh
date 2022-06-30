#!/bin/bash
jupyter-lab --allow-root --ServerApp.token=$JUPYTER_TOKEN --ServerApp.password=$JUPYTER_PASSWORD --notebook-dir=$HOME --no-browser --ip=$LISTEN_ADDRESS
