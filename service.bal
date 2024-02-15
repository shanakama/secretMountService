import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

// An HTTP listener can be configured to accept new connections that are secured via mutual SSL.
listener http:Listener securedEP = new (9090,
    secureSocket = {
        key: {
            certFile: "/home/ballerina/ca.pem",
            keyFile: "/home/ballerina/private.key"
        },
        // Enables mutual SSL.
        mutualSsl: {
            verifyClient: http:REQUIRE,
            cert: "/home/ballerina/ca.pem"
        }
    }
);

service / on securedEP {

    resource function get albums() returns Album[] {
        return [
            {title: "Blue Train", artist: "John Coltrane"},
            {title: "Jeru", artist: "Gerry Mulligan"}
        ];
    }
}