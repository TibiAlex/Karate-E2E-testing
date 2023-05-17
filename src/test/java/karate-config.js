function fn() {
    var env = karate.env; // get system property 'karate.env' karate.log('karate.env system property was:', env);
    var baseUrl = karate.baseUrl;
    if (!env) {
        env = 'dev';
    }

    // Configure log masking
    var LM = Java.type('utils.LogMasking')
    karate.log("LOG_MASKING >>>")
    karate.log(LM)
    karate.configure('logModifier', LM.INSTANCE)

    karate.configure('ssl', true);

    var config

    if (env === 'dev') {
        config = {
            env: env,
            myVarName: 'hello karate',
            token: '3c2076cd81066dbb4eb4aca2442dd104e715068039418e0c2ad567b0becc8aef'
            baseUrl: baseUrl,
        }
    } else if (env === 'java') {
        config = {
            env: env,
            myVarName: 'hello karate java',
            baseUrl: baseUrl,
        }
    } else if (env === 'csharp') {
        config = {
            env: env,
            myVarName: 'hello karate c#',
            baseUrl: baseUrl,
        }
    }
    return config;
}