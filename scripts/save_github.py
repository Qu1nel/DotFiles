import shutil
from pathlib import Path
from queue import Queue
from subprocess import DEVNULL, STDOUT, check_call
from threading import Thread

import colorama
import requests
from bs4 import BeautifulSoup

# USERS: list[str] = ["<user_name1>", "<user_name2>"]
USERS: list[str] = []

colorama.init()


class GetUrlRepositoryFrom(Thread):
    def __init__(self, q: Queue[str], url: str, name: str) -> None:
        super().__init__()
        self.q = q
        self.url = url
        self.name = name

    def run(self) -> None:
        response = get_github_page(self.url)

        if (code := response.status_code) != 200:
            print_color(f"Response is {code} for {self.url}", colorama.Fore.RED)
            return None

        print_color(f"Staring for {self.url}", colorama.Fore.GREEN)

        html = response.text
        soup = BeautifulSoup(html, "html.parser")

        cards = soup.find_all("a", attrs={"itemprop": "name codeRepository"})
        if not cards:
            print_color(
                f"Not found links for {self.name}: {self.url}", colorama.Fore.RED
            )
            return None

        for card in cards:
            url = f"https://github.com/{card['href']}.git"
            self.q.put(url)


class CloneRepository(Thread):
    def __init__(self, url: str, q: Queue[str]) -> None:
        super().__init__()
        self.url = url
        self.q = q

    def run(self) -> None:
        try:
            check_call(["git", "clone", self.url], stdout=DEVNULL, stderr=STDOUT)
        except Exception:
            self.q.put(self.url)
            print_color(f"Bad clone for: {self.url}", colorama.Fore.RED)
            return None
        else:
            print_color(f"Success clone {self.url}", colorama.Fore.GREEN)


def print_color(text: str, color: str, **kwargs) -> None:
    print(f"{color}{text}{colorama.Fore.RESET}", **kwargs)


def get_github_repositories_url_from_user(user_name: str) -> str:
    return f"https://github.com/{user_name}?tab=repositories"


def get_github_page(url: str) -> requests.Response:
    return requests.get(url)


def get_html_from(response: requests.Response):
    return response


def main() -> None:
    urls: Queue[str] = Queue()
    url_workers: list[GetUrlRepositoryFrom] = []

    for name in USERS:
        github_url = get_github_repositories_url_from_user(name)
        worker = GetUrlRepositoryFrom(q=urls, url=github_url, name=name)
        url_workers.append(worker)
        worker.start()

    for u_worker in url_workers:
        u_worker.join()

    print_color("SUCCESS", colorama.Fore.YELLOW)

    names = list(urls.queue)
    git_workers: list[CloneRepository] = []
    bad_repos: Queue[str] = Queue()

    while not urls.empty():
        url = urls.get()
        git_worker = CloneRepository(url, q=bad_repos)
        git_workers.append(git_worker)
        git_worker.start()

    for g_worker in git_workers:
        g_worker.join()

    while not bad_repos.empty():
        url = bad_repos.get()
        print_color(f"Retry clone for {url}", colorama.Fore.GREEN, end=" ")

        try:
            check_call(["git", "clone", url], stdout=DEVNULL, stderr=STDOUT)
        except Exception:
            print_color("Bad!", colorama.Fore.RED)
        else:
            print_color("Done!", colorama.Fore.GREEN)

    for name in names:
        name_repository = name[name.rfind("/") + 1 : name.rfind(".")]
        remove_git_path = Path(f"./{name_repository}/.git")
        try:
            shutil.rmtree(remove_git_path)
        except Exception:
            print_color(f"Remove '.git' in {name_repository}", colorama.Fore.RED)
        else:
            print_color(f"Remove '.git' in {name_repository}", colorama.Fore.GREEN)


if __name__ == "__main__":
    main()
