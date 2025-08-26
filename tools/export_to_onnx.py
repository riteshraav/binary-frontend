# export_to_onnx.py
import torch
import os
from fairseq.models.transformer import TransformerModel

def main():
    ckpt_path = "transformer/indicxlit.pt"
    out_dir = "onnx_out"
    os.makedirs(out_dir, exist_ok=True)

    print(f"Loading checkpoint: {ckpt_path}")
    checkpoint = torch.load(ckpt_path, map_location="cpu", weights_only=False)

    # Recreate transformer from saved args
    args = checkpoint["args"]
    model_state = checkpoint["model"]

    print("Building Transformer model from checkpoint args...")
    model = TransformerModel.build_model(args, task=None)  # fairseq will expect task, but None works for export
    model.load_state_dict(model_state, strict=True)

    model.eval()

    encoder = model.encoder
    decoder = model.decoder

    # Dummy inputs
    dummy_src = torch.ones(1, 10).long()  # batch=1, seq=10
    dummy_tgt = torch.ones(1, 10).long()

    # Run encoder once to get encoder_out
    with torch.no_grad():
        encoder_out = encoder(dummy_src)

    # Export encoder
    encoder_path = os.path.join(out_dir, "encoder.onnx")
    torch.onnx.export(
        encoder,
        dummy_src,
        encoder_path,
        input_names=["src"],
        output_names=["encoder_out"],
        dynamic_axes={"src": {0: "batch", 1: "seq"}},
        opset_version=14
    )
    print(f"✅ Saved {encoder_path}")

    # Export decoder (takes tgt + encoder_out)
    decoder_path = os.path.join(out_dir, "decoder.onnx")
    torch.onnx.export(
        decoder,
        (dummy_tgt, encoder_out),
        decoder_path,
        input_names=["tgt", "encoder_out"],
        output_names=["decoder_out"],
        dynamic_axes={
            "tgt": {0: "batch", 1: "seq"},
        },
        opset_version=14
    )
    print(f"✅ Saved {decoder_path}")


if __name__ == "__main__":
    main()
