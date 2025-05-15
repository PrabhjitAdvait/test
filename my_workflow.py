from prefect import flow, task
import subprocess

@task
def sleep_task():
    for i in range(120):
        subprocess.run(
            ["poetry", "run", "echo", f"Sleeping... {i+1}/120 seconds"],
            check=True,
        )
        subprocess.run(
            ["poetry", "run", "sleep", "1"],
            check=True,
        )

@flow(log_prints=True, name="data_flow_enqueue_test")
def data_flow_enqueue_test():
    sleep_task()
