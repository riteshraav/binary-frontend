import onnxruntime as ort
import numpy as np

encoder_sess = ort.InferenceSession("../model/encoder.onnx", providers=["CPUExecutionProvider"])
decoder_sess = ort.InferenceSession("../model/decoder.onnx", providers=["CPUExecutionProvider"])

print("Encoder inputs:", [(i.name, i.shape, i.type) for i in encoder_sess.get_inputs()])
print("Decoder inputs:", [(i.name, i.shape, i.type) for i in decoder_sess.get_inputs()])

# Encoder expects [1, 10] float
dummy_src = np.random.randn(1, 10).astype(np.float32)
encoder_outs = encoder_sess.run(None, {"src": dummy_src})
print("✅ Encoder ran, outputs shapes:", [x.shape for x in encoder_outs])

# Decoder expects [1, 10, 256] float
dummy_tgt = np.random.randn(1, 10, 256).astype(np.float32)
decoder_outs = decoder_sess.run(None, {"tgt": dummy_tgt})
print("✅ Decoder ran, outputs shapes:", [x.shape for x in decoder_outs])
