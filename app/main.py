from typing import Union
import requests
import json
import yaml
from fastapi import FastAPI, APIRouter, Query, HTTPException, Request, Depends
from typing import Optional, Any

VERSION="1.0"
app = FastAPI()



def load_yaml(file_path):
    """ Loads a yaml file"""
    res = ""
    with open(file_path) as fp:
        res = yaml.load(fp, Loader=yaml.FullLoader)
    return res

PROBLEMS = load_yaml("app/problemType.yaml")
DATA_TYPES = load_yaml("app/dataType.yaml")
#
# Basic APIs
#

@app.get("/")
async def read_root():
    """Root Path"""
    return {"name": "Vedic Math WorkSheet Generator"}

@app.get("/ping")
async def read_ping():
    """Ping API"""
    return {"status": "OK"}

@app.get("/version")
async def read_version():
    """Version API"""
    return {"version": f"{VERSION}"}

@app.get("/dataType", status_code=200)
def fetch_data_types() -> dict:
    """
    Fetch all datatypes
    """
    return DATA_TYPES

@app.get("/dataType/{data_type_id}", status_code=200)
def fetch_data_type(*, data_type_id: str) -> dict:
    """
    Fetch a single data type
    """
    result = [dt for dt in DATA_TYPES["datatypes"] if dt["name"] == data_type_id]
    if result:
        return result[0]
    return {"Error":"Unknown data types id."}

@app.get("/problemsType", status_code=200)
def fetch_problems() -> dict:
    """
    Fetch all problems
    """
    return PROBLEMS

@app.get("/problemsType/{problem_id}", status_code=200)
def fetch_problem(*, problem_id: str) -> dict:
    """
    Fetch a single problem Id
    """
    result = [prob for prob in PROBLEMS["problemstypes"] if prob["name"] == problem_id]
    if result:
        return result[0]
    return {"Error":"Unknown problem id."}

@app.get("/problemsType/{problem_id}", status_code=200)
def gen_problem(*, problem_id: str) -> dict:
    """
    Generate a single problem
    """
    result = [prob for prob in PROBLEMS["problemstypes"] if prob["name"] == problem_id]
    if result:
        return result[0]
    return {"Error":"Unknown problem id."}

