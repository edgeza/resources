import React from "react";
import { Button, Group, rem, Select, TextInput } from "@mantine/core";
import { useForm } from "@mantine/form";
import { DatePickerInput } from "@mantine/dates";
import { IconCalendar } from "@tabler/icons-react";
import { fetchNui } from "../utils/fetchNui";

interface Props {
	handleCreate: () => void;
	id: number;
}

const CreateCharacterModal: React.FC<Props> = (props) => {
	const icon = (
		<IconCalendar style={{ width: rem(18), height: rem(18) }} stroke={1.5} />
	);

	const form = useForm({
		initialValues: {
			firstName: "",
			lastName: "",
			nationality: "",
			gender: "",
			birthdate: new Date("2006-12-31"),
		},
	});

	const handleSubmit = async (values: {
		firstName: string;
		lastName: string;
		nationality: string;
		gender: string;
		birthdate: Date;
	}) => {
		const dateString = values.birthdate.toISOString().slice(0, 10);
		props.handleCreate();
		await fetchNui<string>(
			"createCharacter",
			{ cid: props.id, character: { ...values, birthdate: dateString } },
			{ data: "success" }
		);
	};

	const inputStyles = {
		input: {
			background: 'rgba(255, 255, 255, 0.08)',
			backdropFilter: 'blur(10px)',
			WebkitBackdropFilter: 'blur(10px)',
			border: '1px solid rgba(255, 255, 255, 0.18)',
			color: 'rgba(255, 255, 255, 0.95)',
			borderRadius: '10px',
		},
		label: {
			color: 'rgba(255, 255, 255, 0.9)',
			fontWeight: 500,
			marginBottom: '8px',
		},
	};

	return (
		<form onSubmit={form.onSubmit((values) => handleSubmit(values))} style={{ gap: '20px', display: 'flex', flexDirection: 'column' }}>
			<Group grow>
				<TextInput
					data-autofocus
					required
					placeholder='Your firstname'
					label='Firstname'
					styles={inputStyles}
					{...form.getInputProps("firstName")}
				/>

				<TextInput
					required
					placeholder='Your lastname'
					label='Lastname'
					styles={inputStyles}
					{...form.getInputProps("lastName")}
				/>
			</Group>

			<TextInput
				required
				placeholder='Your nationality'
				label='Nationality'
				styles={inputStyles}
				{...form.getInputProps("nationality")}
			/>

			<Select
				required
				label='Gender'
				placeholder='Pick your gender'
				data={["Male", "Female"]}
				defaultValue='Male'
				allowDeselect={false}
				styles={inputStyles}
				{...form.getInputProps("gender")}
			/>

			<DatePickerInput
				leftSection={icon}
				leftSectionPointerEvents='none'
				label='Pick birthdate'
				placeholder={"YYYY-MM-DD"}
				valueFormat='YYYY-MM-DD'
				defaultValue={new Date("2006-12-31")}
				minDate={new Date("1900-01-01")}
				maxDate={new Date("2006-12-31")}
				styles={inputStyles}
				{...form.getInputProps("birthdate")}
			/>

			<Group justify='flex-end' mt='xl'>
				<Button 
					color='green' 
					variant='light' 
					type='submit'
					h={40}
					radius="md"
					style={{
						background: 'rgba(34, 197, 94, 0.15)',
						backdropFilter: 'blur(10px)',
						WebkitBackdropFilter: 'blur(10px)',
						border: '1px solid rgba(34, 197, 94, 0.3)',
						color: 'rgba(255, 255, 255, 0.95)',
						fontWeight: 600,
						transition: 'all 0.2s ease',
						minWidth: '120px',
					}}
					onMouseEnter={(e: React.MouseEvent<HTMLButtonElement>) => {
						e.currentTarget.style.background = 'rgba(34, 197, 94, 0.25)';
						e.currentTarget.style.borderColor = 'rgba(34, 197, 94, 0.5)';
						e.currentTarget.style.transform = 'translateY(-2px)';
					}}
					onMouseLeave={(e: React.MouseEvent<HTMLButtonElement>) => {
						e.currentTarget.style.background = 'rgba(34, 197, 94, 0.15)';
						e.currentTarget.style.borderColor = 'rgba(34, 197, 94, 0.3)';
						e.currentTarget.style.transform = 'translateY(0)';
					}}
				>
					Create
				</Button>
			</Group>
		</form>
	);
};

export default CreateCharacterModal;
