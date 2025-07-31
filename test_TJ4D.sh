CONFIG_PATH=./projects/SIFormer/configs/TJ4D-SIFormer_det3d_2x4_24e.py
CHECKPOINT_PATH=./projects/SIFormer/checkpoints/best_TJ4D_LiDAR.pth
OUTPUT_NAME=TJ4D-SIFormer
PRED_RESULTS=./tools_det3d/view-of-delft-dataset/pred_results/$OUTPUT_NAME 

GPUS="4"
PORT=${PORT:-19500}
CUDA_VISIBLE_DEVICES="0,1,2,3" \
PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
python -m torch.distributed.launch \
    --nproc_per_node=$GPUS \
    --master_port=$PORT \
    $(dirname "$0")/tools_det3d/test.py \
    --config $CONFIG_PATH \
    --checkpoint $CHECKPOINT_PATH \
    --eval mAP \
    --launcher pytorch ${@:4}

# python -m torch.distributed.launch \
#     --nproc_per_node=$GPUS \
#     --master_port=$PORT \
#     $(dirname "$0")/tools_det3d/test.py \
#     --format-only \
#     --eval-options submission_prefix=$PRED_RESULTS \
#     --config $CONFIG_PATH \
#     --checkpoint $CHECKPOINT_PATH \
#     --launcher pytorch ${@:4}
