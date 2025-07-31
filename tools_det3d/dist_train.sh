# TORCH_DISTRIBUTED_DEBUG=DETAIL
# tmux new -s train3d
# conda activate SIFormer

CONFIG=$1
GPUS=$2
NNODES=${NNODES:-1}
NODE_RANK=${NODE_RANK:-0}
PORT=${PORT:-29500} # if using multi-exp should change PORT
MASTER_ADDR=${MASTER_ADDR:-"127.0.0.1"}

CUDA_VISIBLE_DEVICES="0,1,2,3" \
PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
python -m torch.distributed.launch \
    --nnodes=$NNODES \
    --node_rank=$NODE_RANK \
    --master_addr=$MASTER_ADDR \
    --nproc_per_node=$GPUS \
    --master_port=$PORT \
    $(dirname "$0")/train.py \
    --config $CONFIG \
    --launcher pytorch ${@:3}
    
# NOTE: remind train epochs in config file
# nohup python -u ./tools_det3d/train.py --config ./projects/KD4R/configs/vod-KD4R_baseline_4x1_80e.py > vod-KD4R_baseline_4x1_80e.log 2>&1 &
# nohup bash ./tools_det3d/dist_train.sh ./projects/SIFormer/configs/ablation_robustness/vod-SIFormer_det3d_2x4_24e_drop.py 4 > vod-SIFormer_det3d_2x4_24e_drop.log 2>&1 &
# nohup bash ./tools_det3d/dist_train.sh ./projects/SIFormer/configs/vod-SIFormer_det3d_2x4_24e.py 4 > vod-SIFormer_det3d_2x4_24e.log 2>&1 &
