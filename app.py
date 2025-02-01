from fastapi import FastAPI
import subprocess

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "LKH-3 API is running"}

@app.post("/solve")
def solve(problem_file: str):
    result = subprocess.run(["./LKH", problem_file], capture_output=True, text=True)
    return {"output": result.stdout}
