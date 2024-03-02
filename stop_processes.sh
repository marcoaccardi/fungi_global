#!/bin/bash
## THIS SCRIPT RUNS WHEN YOU OPEN A TERMINAL via .zprofile
echo "Starting..."

# STOP ALL NODE PROCESSES
killall  node

## STOP LLM PROCESS IF IT'S RUNNING...
echo "Checking if LLM is running..."
PORT_LLM=9090
PID_LLM=$(lsof -ti:$PORT_LLM)

if [ ! -z "$PID_LLM" ]; then
    echo "Found process $PID on port $PORT_LLM, terminating..."
    kill -9 $PID_LLM
fi

## STOP PROCESSES FRONTEND MAP IF IT'S RUNNING...
PORT_FE_MAP=5174 
PID_FE_MAP=$(lsof -ti:$PORT_FE_MAP)

echo "check if chat bot frontend is running..."
if [ ! -z "$PID_FE_MAP" ]; then
    echo "Found process $PID on port $PORT_FE_MAP, terminating..."
    kill -9 $PID_FE_MAP
fi

## STOP PROCESSES FRONTEND CAHTBOT IF IT'S RUNNING...
PORT_FE_CHATBOT=5173 
PID_FE_CHATBOT=$(lsof -ti:$PORT_FE_CHATBOT)

echo "check if chat bot frontend is running..."
if [ ! -z "$PID_FE_CHATBOT" ]; then
    echo "Found process $PID on port $PORT_FE_CHATBOT, terminating..."
    kill -9 $PID_FE_CHATBOT
fi

# quit ableton live
osascript -e 'tell application "Ableton Live 11 Trial" to quit'
osascript -e 'tell application "Max" to quit'