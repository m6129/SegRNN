if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/LongForecasting" ]; then
    mkdir ./logs/LongForecasting
fi

if [ ! -d "./logs/LongForecasting/univariate" ]; then
    mkdir ./logs/LongForecasting/univariate
fi
model_name=SegRNN
seq_len=60

root_path_name=./dataset/
data_path_name=de_small.csv
model_id_name=de_small
data_name=custom
for pred_len in 24 36 48 60
do
    python -u run_longExp.py \
      --is_training 1 \
      --root_path $root_path_name \
      --data_path $data_path_name \
      --model_id $model_id_name'_'$seq_len'_'$pred_len \
      --model $model_name \
      --data $data_name \
      --features S \
      --seq_len $seq_len \
      --pred_len $pred_len \
      --seg_len 12 \
      --enc_in 1 \
      --d_model 512 \
      --dropout 0 \
      --train_epochs 30 \
      --patience 10 \
      --rnn_type gru \
      --dec_way pmf \
      --channel_id 0 \
      --itr 1 --batch_size 16 --learning_rate 0.0002 > logs/LongForecasting/univariate/$model_name'_'$model_id_name'_'$seq_len'_'$pred_len.log
done
