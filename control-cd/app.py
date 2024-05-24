import subprocess

from flask import Flask, render_template, redirect, url_for, request
import os
import shutil
from git import Repo
from io import StringIO
import sys
from dotenv import load_dotenv

app = Flask(__name__)

log_stream = StringIO()


def handle_remove_readonly(func, path, exc):
    import stat
    os.chmod(path, stat.S_IWRITE)
    func(path)


@app.route('/')
def index():
    log_contents = log_stream.getvalue()
    return render_template('index.html', logs=log_contents)


@app.route('/update', methods=['POST'])
def update_button():
    sys.stdout = log_stream
    sys.stderr = log_stream
    load_dotenv()
    try:
        repo_url = os.getenv("GIT_REPO")
        repo_path = "cicd"

        if os.path.exists(repo_path):
            shutil.rmtree(repo_path, onerror=handle_remove_readonly)
            print(f"Old repository {repo_path} removed")

        Repo.clone_from(repo_url, repo_path)
        print(f"Repository {repo_url} was downloaded to {repo_path}")

        ci_cd_path = os.path.join(repo_path)
        if not os.path.exists(ci_cd_path):
            os.makedirs(ci_cd_path)
            print(f"Directory {ci_cd_path} created.")
            terraform_init = subprocess.run(["terraform", "init"], cwd=ci_cd_path, capture_output=True, text=True)
            print(terraform_init)

    except Exception as e:
        print(f"Error: {e}")
    finally:
        sys.stdout = sys.__stdout__
        sys.stderr = sys.__stderr__

    return redirect(url_for('index'))


@app.route('/start', methods=['POST'])
def start_button():
    sys.stdout = log_stream
    sys.stderr = log_stream
    try:
        ci_cd_path = "cicd/terraform"
        if os.path.exists(ci_cd_path):
            print(f"Folder {ci_cd_path} already exists")
            result = subprocess.run(["terraform", "apply", "-auto-approve"], cwd=ci_cd_path, capture_output=True, text=True)
            print(result.stdout)
            print(result.stderr)
        else:
            print(f"Directory {ci_cd_path} doesn't exist!")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        sys.stdout = sys.__stdout__
        sys.stderr = sys.__stderr__

    return redirect(url_for('index'))


@app.route('/remove', methods=['POST'])
def remove_button():
    print("Button 3 was pressed")
    return redirect(url_for('index'))


if __name__ == '__main__':
    app.run(debug=True)
