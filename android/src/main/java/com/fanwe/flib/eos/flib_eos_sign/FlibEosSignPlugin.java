package com.fanwe.flib.eos.flib_eos_sign;

import android.text.TextUtils;

import com.sd.lib.eos.rpc.helper.cypto.digest.Sha256;
import com.sd.lib.eos.rpc.helper.cypto.ec.EcDsa;
import com.sd.lib.eos.rpc.helper.cypto.ec.EcSignature;
import com.sd.lib.eos.rpc.helper.cypto.ec.EosPrivateKey;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlibEosSignPlugin
 */
public class FlibEosSignPlugin implements MethodCallHandler
{
    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar)
    {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter.fanwe.com/flib_eos_sign");
        channel.setMethodCallHandler(new FlibEosSignPlugin());
    }

    @Override
    public void onMethodCall(MethodCall call, Result result)
    {
        final String methodName = call.method;

        switch (methodName)
        {
            case "generatePrivateKey":
                try
                {
                    result.success(new EosPrivateKey().toString());
                } catch (Exception e)
                {
                    result.success(null);
                }
                break;
            case "toPublicKey":
                try
                {
                    final String privateKey = call.arguments();
                    if (TextUtils.isEmpty(privateKey))
                    {
                        result.success(null);
                        return;
                    }

                    result.success(new EosPrivateKey(privateKey).getPublicKey().toString());
                } catch (Exception e)
                {
                    result.success(null);
                }
                break;
            case "sign":
                try
                {
                    final byte[] data = call.argument("data");
                    if (data == null || data.length <= 0)
                    {
                        result.success(null);
                        return;
                    }

                    final String privateKey = call.argument("privateKey");
                    if (TextUtils.isEmpty(privateKey))
                    {
                        result.success(null);
                        return;
                    }

                    final Sha256 sha256 = Sha256.from(data);
                    final EcSignature signature = EcDsa.sign(sha256, new EosPrivateKey(privateKey));
                    result.success(signature.toString());
                } catch (Exception e)
                {
                    result.success(null);
                }
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}
