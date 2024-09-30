import asyncio
import csv
import json

import aiofiles
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.orm import sessionmaker

from db import Base, CombinedData

DATABASE_URL = "sqlite+aiosqlite:///data.db"


async def read_file(file_path: str, is_file1: bool = False) -> list[list[str]]:
    data = []
    if is_file1:
        delimiter = ","
        encoding = "utf-8"
    else:
        delimiter = ";"
        encoding = "windows-1251"

    async with aiofiles.open(file_path, "r", encoding=encoding) as txt_file:
        async for line in txt_file:
            row = next(csv.reader([line.strip()], delimiter=delimiter))
            if len(row) > 1:
                data.append((row[0].strip(), row[1].strip().replace('"', "")))
    return data


async def combine_and_sort(file1: str, file2: str) -> list[list[str]]:
    data1, data2 = await asyncio.gather(
        read_file(file1, is_file1=True), read_file(file2)
    )

    combined_data = data1 + data2
    sorted_data = sorted(combined_data, key=lambda x: x[1])
    return sorted_data


async def save_to_json(data: list[list[str]], output_file: str) -> None:
    async with aiofiles.open(output_file, "w", encoding="utf-8") as f:
        await f.write(json.dumps(data, ensure_ascii=False, indent=4))


async def save_to_database(data: list[list[str]]) -> None:
    engine = create_async_engine(DATABASE_URL, echo=True)
    async_session = sessionmaker(engine, expire_on_commit=False, class_=AsyncSession)

    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)
        await conn.run_sync(Base.metadata.create_all)

    session: AsyncSession
    async with async_session() as session:
        for row in data:
            new_record = CombinedData(column1=row[0], column2=row[1])
            session.add(new_record)
        await session.commit()

    await engine.dispose()


async def save_data(data: list[list[str]], json_file: str) -> None:
    await asyncio.gather(
        save_to_json(data, json_file), save_to_database(data)
    )

async def main(file1: str, file2: str, json_output: str) -> None:
    sorted_data = await combine_and_sort(file1, file2)
    await save_data(sorted_data, json_output)


if __name__ == "__main__":
    # Пример использования
    file1 = "Тестовый файл1.txt"
    file2 = "Тестовый файл2.txt"
    json_output = "output.json"
    db_name = "data.db"

    asyncio.run(main(file1, file2, json_output))
