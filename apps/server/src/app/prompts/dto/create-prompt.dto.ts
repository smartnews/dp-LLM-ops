import { Field, InputType } from "@nestjs/graphql";
import {ApiProperty} from "@nestjs/swagger";
import {IsObject, IsString} from "class-validator";

export class CreatePromptDto {

  @ApiProperty({
    description: "The prompt name",
    type: String,
    example: "prompt-name",
    nullable: false
  })
  @IsString()
  name: string;

  @ApiProperty({
    description: "The project id",
    type: String,
    example: "clvxpjgyl00012p0zmruujmpr",
    nullable: false
  })
  @IsString()
  projectId: string;

}
