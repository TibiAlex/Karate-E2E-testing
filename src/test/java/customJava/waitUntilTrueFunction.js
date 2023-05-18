function fn(retries, timeBetweenRetriesMs, moderatorToken) {

    let jsonData = read('classpath:payloads/java/loadMyCoursesResponse.json');
    karate.log(jsonData);

    for (let retryNo = 0; retryNo < retries; retryNo++) {
        var result = karate.call('function_poll.feature', {moderatorToken: moderatorToken}).response;

        karate.log('Polling on action success. Elapsed ms=', retryNo * timeBetweenRetriesMs);

        // ###
        var ok = false;
        var notoke = true;

        // if (result[0].file !== jsonData[0].file) {
        //     karate.log("file");
        //     notoke = false;
        // }
        // if (result[0].path !== jsonData[0].path) {
        //     karate.log("path");
        //     notoke = false;
        // }
        // if (result[0].email !== jsonData[0].email) {
        //     karate.log("email");
        //     notoke = false;
        // }
        // if (result[0].title !== jsonData[0].title) {
        //     karate.log("title");
        //     notoke = false;
        // }if (result[0].description !== jsonData[0].description) {
        //     karate.log("description");
        //     notoke = false;
        // }if (result[0].type !== jsonData[0].type) {
        //     karate.log("type");
        //     notoke = false;
        // }
        // if (result[0].rating !== jsonData[0].rating) {
        //     karate.log("rating");
        //     notoke = false;
        // }

        if(notoke === true) {
            ok = true
        }
        // ###

        if (ok === true) {
            karate.log('Exit condition satisfied. Elapsed ms=', retryNo * timeBetweenRetriesMs);
            return true;
        }

        karate.log('Condition not satisfied. Will try again.');
        // uncomment / modify the sleep time as per your wish
        java.lang.Thread.sleep(timeBetweenRetriesMs);
    }

    return false;
}