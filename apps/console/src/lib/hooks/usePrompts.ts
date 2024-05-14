import { useQuery } from "@tanstack/react-query";
import { gqlClient } from "../graphql";
import { useCurrentProject } from "./useCurrentProject";
import { GET_ALL_PROMPTS } from "~/graphql/definitions/queries/prompts";

export const usePrompts = () => {
  const { projectId } = useCurrentProject();

  let enabled = true
  if (projectId === null) {
    enabled = false;
  }

  const { data, isLoading } = useQuery({
    queryKey: ["prompts", projectId],
    queryFn: () =>
      gqlClient.request(GET_ALL_PROMPTS, {
        data: { projectId: projectId },
      }),
    enabled: enabled,
  });

  return {
    prompts: data?.prompts,
    isLoading,
  };
};
