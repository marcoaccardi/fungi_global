#!/bin/bash
## THIS SCRIPT RUNS WHEN YOU OPEN A TERMINAL via .zprofile
echo "Starting..."

## INIT BASE PATH
FUNGI=/Users/fungi/Desktop/fungi-collection-2024

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
# RUN LLM
source $FUNGI/fungi_fullstack_chat/src/llm/src/venv/bin/activate 
cd $FUNGI/fungi_fullstack_chat/src/llm/src 
uvicorn app:create_app --host 0.0.0.0 --port 9090 --reload &
echo "LLM server is running..."

## STOP PROCESSES FRONTEND CAHTBOT IF IT'S RUNNING...
PORT_FE_CHATBOT=5173 
PID_FE_CHATBOT=$(lsof -ti:$PORT_FE_CHATBOT)

echo "check if chat bot frontend is running..."
if [ ! -z "$PID_FE_CHATBOT" ]; then
    echo "Found process $PID on port $PORT_FE_CHATBOT, terminating..."
    kill -9 $PID_FE_CHATBOT
fi

# RUN FRONTEND LLM
cd $FUNGI/fungi_fullstack_chat/src/frontend/fungi-chat
npm run dev &

## STOP PROCESSES FRONTEND MAP IF IT'S RUNNING...
PORT_FE_MAP=5174 
PID_FE_MAP=$(lsof -ti:$PORT_FE_MAP)

echo "check if chat bot frontend is running..."
if [ ! -z "$PID_FE_MAP" ]; then
    echo "Found process $PID on port $PORT_FE_MAP, terminating..."
    kill -9 $PID_FE_MAP
fi

# RUN FRONTEND MAP
cd $FUNGI/fungi_map
npm run dev &


#RUN MAX APPLICATION
echo "RUN MAX..."
open $FUNGI/fungi_max_env/fungi_max_env.maxproj

# RUN ABLETON LIVE PROJECT
echo "RUN ABLETON LIVE..."
open $FUNGI/fungi_sound/fungi_sonification_2024\ Project/fungi_sonification_2024.als