const { ApolloServer } = require('apollo-server');
const { ApolloServerPluginUsageReporting } = require("apollo-server-core");

module.exports = async ({ getBuiltMesh, documents, logger }) => {
  const { schema } = await getBuiltMesh();
  const apolloServer = new ApolloServer({
    schema,
    apollo: {key: process.env.APOLLO_KEY, graphRef: process.env.APOLLO_GRAPH_REF},
    context: ({ req }) => req,
    introspection: true,
    playground: true,
    plugins: [
      ApolloServerPluginUsageReporting({
        generateClientInfo: ({request}) => {
          const headers = request.http && request.http.headers;
          if(headers) {
            return {
              clientName: headers['apollographql-client-name'],
              clientVersion: headers['apollographql-client-version'],
            };
          } else {
            return {
              clientName: "Unknown Client",
              clientVersion: "Unversioned",
            };
          }
        },
      }),
    ],    
    playground: {
      tabs: documents.map(({ location, rawSDL }) => ({
        name: location,
        endpoint: '/graphql',
        query: rawSDL,
      })),
    },
  });

  const { url } = await apolloServer.listen(4000);
  logger.info(`🚀 Server ready at ${url}`);
};