/*
  Warnings:

  - Added the required column `status` to the `UserTasks` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "UserTaskStatus" AS ENUM ('PENDING', 'COMPLETE');

-- AlterTable
ALTER TABLE "UserTasks" ADD COLUMN     "status" "UserTaskStatus" NOT NULL;
