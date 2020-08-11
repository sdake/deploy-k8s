usage() { echo "Usage: $0 -c [create|destroy]" 1>&2; exit 1; }

while getopts ":c:" o; do
    case "${o}" in
        c)
            cmd="${OPTARG}"
            ;;
        *)
            usage
            ;;
    esac
done

if [ "${cmd}" != "create" ] && [ "${cmd}" != "destroy" ]; then
    usage
fi

if [ "${cmd}" == "create" ]; then
	ansible-playbook site.yml -i inv.yml
fi

if [ "${cmd}" == "destroy" ]; then
	ansible-playbook destroy.yml -i inv.yml
fi
