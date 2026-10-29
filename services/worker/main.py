import logging
import os
import time

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")

APP_VERSION = os.getenv("APP_VERSION", "dev")
INTERVAL = float(os.getenv("WORKER_INTERVAL", "10"))


def main() -> None:
    logging.info("worker started version=%s interval=%s", APP_VERSION, INTERVAL)
    while True:
        logging.info("heartbeat version=%s", APP_VERSION)
        time.sleep(INTERVAL)


if __name__ == "__main__":
    main()
