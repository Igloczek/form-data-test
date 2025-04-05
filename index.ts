import { serve } from "bun";

const server = serve({
  port: 3000,
  routes: {
    "/": async (req) => {
      if (req.method === "POST") {
        try {
          const form = await req.formData();

          for (const [key, value] of form.entries()) {
            console.log(`${key}:`, value);
          }

          return Response.json({
            message: "OK",
            form,
          });
        } catch (err) {
          console.error("formData() failed:", err);
          return new Response("Failed to parse form", { status: 500 });
        }
      }

      return new Response("Send a POST with multipart/form-data");
    },
  },
});

console.log(`Listening on localhost:${server.port}`);
