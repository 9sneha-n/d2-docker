from d2_docker import utils

DESCRIPTION = "Show docker logs"


def setup(parser):
    parser.add_argument("image", metavar="IMAGE", nargs="?", help="Hub docker image")
    parser.add_argument("-f", "--follow", action="store_true", help="Follow log output")
    parser.add_argument("-s", "--service", help="Container service")


def run(args):
    image_name = args.image or utils.get_running_image_name()
    utils.logger.info("Show logs: {}".format(image_name))
    args = ["logs", "-t", "-f" if args.follow else None, args.service]
    utils.run_docker_compose(filter(bool, args), image_name)


def get_logs(args):
    image_name = args.image
    tail_count = args.limit or 10_000
    res = utils.run_docker_compose(
        ["logs", "--tail={}".format(tail_count)], data_image=image_name, capture_output=True
    )
    return res.stdout.decode("utf-8")
